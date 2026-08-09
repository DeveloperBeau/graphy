<script>
  import ConstantRow from './ConstantRow.svelte';

  export let state = [];

  function listConstants(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="constants-panel">
  <ConstantRow />
  <p>{listConstants(state)}</p>
</div>

<style>
  .constants-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
