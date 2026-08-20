#!/usr/bin/env python3
"""Figure 1A — Sankey-style breakdown of attempted reproducibility claims.

Counts are read from Data/sankey_counts.csv (written by all_analyses.R); nothing here is hard-coded, so the figure always matches the
stats. Run all_analyses.R first, then: python figure1_sankey.py

Renders only the diagram; the figure number, title, and explanatory note are
provided by the surrounding manuscript (docx caption), not by the image.
"""
import csv
import os
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.path import Path

_HERE = os.path.dirname(os.path.abspath(__file__))
_COUNTS = os.path.join(_HERE, "Data/sankey_counts.csv")
if not os.path.exists(_COUNTS):
    raise SystemExit(
        "sankey_counts.csv not found. Run all_analyses.R first.")
with open(_COUNTS, newline="") as _f:
    _c = {row["key"]: int(row["value"]) for row in csv.DictReader(_f)}

TOTAL       = _c["TOTAL"]
AGREE       = _c["AGREE"]
DISAGREE    = _c["DISAGREE"]
ERR_SCORE   = _c["ERR_SCORE"]    # SCORE pipeline error; LLM defensible
ERR_NEITHER = _c["ERR_NEITHER"]  # both verdicts defensible
ERR_LLM     = _c["ERR_LLM"]      # LLM error; SCORE defensible
ERR_BOTH    = _c["ERR_BOTH"]     # both wrong

assert AGREE + DISAGREE == TOTAL
assert ERR_SCORE + ERR_NEITHER + ERR_LLM + ERR_BOTH == DISAGREE

# Layout: leave wide gutters on both sides so external labels have room.
COL_X = [0.16, 0.42, 0.66]
BOX_W = 0.10
GAP = 0.008
Y_TOP, Y_BOT = 0.94, 0.06
H = Y_TOP - Y_BOT

FS_LABEL = 15  # box labels
FS_VALUE = 14  # numeric values under labels


def h(n):
    return (n / TOTAL) * H


def box(ax, x, top, n, fill, edge):
    bh = h(n)
    rect = patches.FancyBboxPatch(
        (x, top - bh), BOX_W, bh,
        boxstyle="round,pad=0.0015,rounding_size=0.004",
        linewidth=1.1, facecolor=fill, edgecolor=edge, zorder=3)
    ax.add_patch(rect)
    return {'x_left': x, 'x_right': x + BOX_W, 'top': top, 'bot': top - bh,
            'mid': top - bh/2, 'h': bh}


def flow(ax, x1, t1, b1, x2, t2, b2, color, alpha=0.42):
    mid = (x1 + x2) / 2
    verts = [(x1, t1), (mid, t1), (mid, t2), (x2, t2),
             (x2, b2), (mid, b2), (mid, b1), (x1, b1), (x1, t1)]
    codes = [Path.MOVETO, Path.CURVE4, Path.CURVE4, Path.CURVE4,
             Path.LINETO, Path.CURVE4, Path.CURVE4, Path.CURVE4, Path.CLOSEPOLY]
    ax.add_patch(patches.PathPatch(Path(verts, codes), facecolor=color,
                                   edgecolor='none', alpha=alpha, zorder=2))


def label_left(ax, b, lines):
    x = b['x_left'] - 0.012
    y = b['mid']
    text = "\n".join(lines)
    ax.text(x, y, text, ha='right', va='center',
            fontsize=FS_LABEL, zorder=4)


def label_right(ax, b, lines, target_y=None):
    x_text = b['x_right'] + 0.022
    y = target_y if target_y is not None else b['mid']
    text = "\n".join(lines)
    if target_y is not None and abs(target_y - b['mid']) > 0.01:
        ax.plot([b['x_right'] + 0.003, x_text - 0.005],
                [b['mid'], y],
                color='#555', linewidth=0.8, zorder=4)
    ax.text(x_text, y, text, ha='left', va='center',
            fontsize=FS_LABEL, zorder=4)


def label_above(ax, b, lines, dy=0.025):
    x = b['x_left'] + BOX_W / 2
    y = b['top'] + dy
    text = "\n".join(lines)
    ax.text(x, y, text, ha='center', va='bottom',
            fontsize=FS_LABEL, zorder=4)


def label_below(ax, b, lines, dy=0.025):
    x = b['x_left'] + BOX_W / 2
    y = b['bot'] - dy
    text = "\n".join(lines)
    ax.text(x, y, text, ha='center', va='top',
            fontsize=FS_LABEL, zorder=4)


def build(ax, P):
    ax.set_xlim(0, 1); ax.set_ylim(0, 1); ax.axis('off'); ax.set_aspect('auto')

    # Column 1: agreement / disagreement. (The full-sample bar was removed at
    # R2's request -- the caption states n = 340; the two boxes stack to the
    # full sample height, so the total is still implicit in the geometry.)
    b_agree = box(ax, COL_X[1], Y_TOP, AGREE, P['agree'], P['agree_edge'])
    y2 = Y_TOP - h(AGREE) - GAP
    b_dis = box(ax, COL_X[1], y2, DISAGREE, P['disagree'], P['disagree_edge'])

    # Column 2: SCORE-error / Neither / LLM-error / Both (top -> bottom)
    # Top of col 3 aligned with top of disagreement box for clean flow.
    y3 = y2
    GAP3 = 0.004  # small gap between adjacent col-3 boxes

    b_score = box(ax, COL_X[2], y3, ERR_SCORE, P['score'], P['score_edge'])
    y3 = b_score['bot'] - GAP3

    b_neither = box(ax, COL_X[2], y3, ERR_NEITHER, P['neither'], P['neither_edge'])
    y3 = b_neither['bot'] - GAP3

    b_llm = box(ax, COL_X[2], y3, ERR_LLM, P['llm_err'], P['llm_err_edge'])
    y3 = b_llm['bot'] - GAP3

    b_both = box(ax, COL_X[2], y3, ERR_BOTH, P['both'], P['both_edge'])

    # Flows col2 (disagree) -> col3. Source segments along the disagree box's
    # right edge in same top-to-bottom order; destination segments are each
    # col-3 box's left edge.
    src_y = y2  # start at top of disagree box
    for n, dest, color in [
        (ERR_SCORE,   b_score,   P['score_flow']),
        (ERR_NEITHER, b_neither, P['neither_flow']),
        (ERR_LLM,     b_llm,     P['llm_err_flow']),
        (ERR_BOTH,    b_both,    P['both_flow']),
    ]:
        src_top = src_y
        src_bot = src_top - h(n)
        flow(ax, b_dis['x_right'], src_top, src_bot,
             dest['x_left'], dest['top'], dest['bot'],
             color)
        src_y = src_bot

    # ---- External labels ----
    label_left(ax, b_agree, ["Agreement with SCORE", f"{AGREE} ({100*AGREE/TOTAL:.1f}%)"])
    label_left(ax, b_dis,   ["Disagreement", f"{DISAGREE} ({100*DISAGREE/TOTAL:.1f}%)"])

    # Col 3 boxes are small; pin each label to its own y anchor along the
    # disagreement-box vertical range with leader lines back to box midpoints.
    # Single-line labels keep vertical packing reasonable.
    col3_top = b_score['top']

    # Header over the adjudication column: names the agent whose judgment
    # was wrong, so "SCORE verdict wrong" cannot be read as "SCORE found
    # an error in the paper" (Reviewer 1's ambiguity).
    ax.text(COL_X[2], col3_top + 0.062,
            "Adjudication: whose verdict was wrong?",
            ha='left', va='bottom', fontsize=FS_LABEL, style='italic',
            color='#333', zorder=4)

    anchors = [col3_top + 0.015,
               col3_top - 0.045,
               col3_top - 0.105,
               col3_top - 0.165]
    label_right(ax, b_score,
                [f"SCORE verdict wrong: {ERR_SCORE} ({100*ERR_SCORE/TOTAL:.1f}%)"],
                target_y=anchors[0])
    label_right(ax, b_neither,
                [f"Both verdicts defensible: {ERR_NEITHER} ({100*ERR_NEITHER/TOTAL:.1f}%)"],
                target_y=anchors[1])
    label_right(ax, b_llm,
                [f"LLM verdict wrong: {ERR_LLM} ({100*ERR_LLM/TOTAL:.1f}%)"],
                target_y=anchors[2])
    label_right(ax, b_both,
                [f"Both verdicts wrong: {ERR_BOTH} ({100*ERR_BOTH/TOTAL:.1f}%)"],
                target_y=anchors[3])


clean = {
    'total': '#ececec',     'total_edge': '#555',
    'agree': '#cfe2d4',     'agree_edge': '#3f7a5a',    'agree_flow':   '#a6cbb1',
    'disagree': '#f5d4bf',  'disagree_edge': '#b3623a', 'disagree_flow':'#e6b89c',
    # Greens: LLM defensible
    'score':   '#dbe7d5',   'score_edge':   '#638a5a',  'score_flow':   '#bcd3b4',
    'neither': '#eef0d8',   'neither_edge': '#8a8a4a',  'neither_flow': '#dadcaf',
    # Reds: LLM at fault
    'llm_err': '#e8c6c0',   'llm_err_edge': '#b04f3f',  'llm_err_flow': '#d6a59b',
    'both':    '#d8a8a0',   'both_edge':    '#8a3a2c',  'both_flow':    '#c08a82',
}

fig, ax = plt.subplots(figsize=(11, 6.5), dpi=160)
plt.rcParams.update({'font.family': 'sans-serif',
                     'font.sans-serif': ['Helvetica', 'Arial', 'DejaVu Sans']})
build(ax, clean)
plt.tight_layout(rect=[0, 0, 1, 1])
_OUT = os.path.join(_HERE, "output")
os.makedirs(_OUT, exist_ok=True)
fig.savefig(os.path.join(_OUT, "Figure1A_sankey_clean.pdf"), bbox_inches='tight')
fig.savefig(os.path.join(_OUT, "Figure1A_sankey_clean.png"), bbox_inches='tight', dpi=200)
plt.close(fig)
print("Wrote output/Figure1A_sankey_clean.{pdf,png}")
