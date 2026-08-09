<script>
  export let state = [];

  function hintKeys(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kbd-hint">
  <p>{hintKeys(state)}</p>
</div>

<style>
  .kbd-hint {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
