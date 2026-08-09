<script>
  export let state = [];

  function emitDigit(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="digit-key">
  <p>{emitDigit(state)}</p>
</div>

<style>
  .digit-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
