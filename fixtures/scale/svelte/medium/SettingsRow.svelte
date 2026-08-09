<script>
  import ToggleSwitch from './ToggleSwitch.svelte';

  export let state = [];

  function rowLabel(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="settings-row">
  <ToggleSwitch />
  <p>{rowLabel(state)}</p>
</div>

<style>
  .settings-row {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
