<script>
  export let state = [];

  function clearEntry(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="clear-key">
  <p>{clearEntry(state)}</p>
</div>

<style>
  .clear-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
