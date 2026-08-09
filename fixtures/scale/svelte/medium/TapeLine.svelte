<script>
  export let state = [];

  function lineTimestamp(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="tape-line">
  <p>{lineTimestamp(state)}</p>
</div>

<style>
  .tape-line {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
