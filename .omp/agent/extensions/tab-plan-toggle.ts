import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { CustomEditor } from "@oh-my-pi/pi-coding-agent/modes/components";
import { canonicalKeyId, parseKey } from "@oh-my-pi/pi-tui";

/**
 * Make Tab context-sensitive:
 * - autocomplete open  → navigate / confirm as usual (select.down)
 * - normal editor input → app.plan.toggle (write <-> plan)
 *
 * OMP registers app.plan.toggle as a custom key handler that always consumes
 * the chord before the editor sees it. This subclass only bypasses that path
 * while the autocomplete popup is visible.
 *
 * Chat paging (Ctrl+U / Ctrl+E) is intentionally NOT handled here — OMP page
 * bindings only move the multi-line draft cursor. WezTerm ScrollByPage owns
 * those chords for transcript scrollback.
 */
class TabPlanToggleEditor extends CustomEditor {
	override handleInput(data: string): void {
		const parsed = parseKey(data);
		const canonical = parsed !== undefined ? canonicalKeyId(parsed) : undefined;
		if (canonical === "tab" && this.isShowingAutocomplete()) {
			// Skip CustomEditor app/custom shortcut interception so Tab reaches
			// Editor autocomplete navigation (tui.select.down).
			this.handleDraftEdit(data);
			return;
		}
		super.handleInput(data);
	}
}

export default function tabPlanToggleExtension(pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		if (!ctx.hasUI) return;
		ctx.ui.setEditorComponent((tui, theme, _keybindings) => new TabPlanToggleEditor(tui, theme));
	});
}
