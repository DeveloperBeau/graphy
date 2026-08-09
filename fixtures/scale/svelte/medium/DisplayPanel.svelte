<script>
  import ExpressionLine from './ExpressionLine.svelte';
  import ResultLine from './ResultLine.svelte';

  export let state = [];

  function displayState(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="display-panel">
  <ExpressionLine />
  <ResultLine />
  <p>{displayState(state)}</p>
</div>

<style>
  .display-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
