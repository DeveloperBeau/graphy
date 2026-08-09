<script>
  export let state = [];

  function requestEvaluate(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="equals-key">
  <p>{requestEvaluate(state)}</p>
</div>

<style>
  .equals-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
