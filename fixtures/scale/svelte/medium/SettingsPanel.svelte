<script>
  import SettingsRow from './SettingsRow.svelte';
  import PrecisionPicker from './PrecisionPicker.svelte';
  import AngleModePicker from './AngleModePicker.svelte';
  import RoundingPicker from './RoundingPicker.svelte';

  export let state = [];

  function persistSettings(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="settings-panel">
  <SettingsRow />
  <PrecisionPicker />
  <AngleModePicker />
  <RoundingPicker />
  <p>{persistSettings(state)}</p>
</div>

<style>
  .settings-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
