<script>
  export let state = [];

  function emitOperator(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="operator-key">
  <p>{emitOperator(state)}</p>
</div>

<style>
  .operator-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
