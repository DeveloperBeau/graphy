<script>
  import CopyButton from './CopyButton.svelte';

  export let state = [];

  function formatResult(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="result-line">
  <CopyButton />
  <p>{formatResult(state)}</p>
</div>

<style>
  .result-line {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
