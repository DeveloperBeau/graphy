<script>
  import TapeLine from './TapeLine.svelte';

  export let state = [];

  function scrollTape(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="tape-panel">
  <TapeLine />
  <p>{scrollTape(state)}</p>
</div>

<style>
  .tape-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
