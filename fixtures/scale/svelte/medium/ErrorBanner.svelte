<script>
  export let state = [];

  function describeError(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="error-banner">
  <p>{describeError(state)}</p>
</div>

<style>
  .error-banner {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
