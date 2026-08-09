<script>
  import HistoryPanel from './HistoryPanel.svelte';
  import TapePanel from './TapePanel.svelte';
  import SettingsPanel from './SettingsPanel.svelte';
  import UnitConverter from './UnitConverter.svelte';
  import ConstantsPanel from './ConstantsPanel.svelte';
  import FunctionPalette from './FunctionPalette.svelte';
  import KeyboardHelp from './KeyboardHelp.svelte';

  export let state = [];

  function activePanel(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="side-panels">
  <HistoryPanel />
  <TapePanel />
  <SettingsPanel />
  <UnitConverter />
  <ConstantsPanel />
  <FunctionPalette />
  <KeyboardHelp />
  <p>{activePanel(state)}</p>
</div>

<style>
  .side-panels {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
