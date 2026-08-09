<script>
  export let state = [];

  function copyResult(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="copy-button">
  <p>{copyResult(state)}</p>
</div>

<style>
  .copy-button {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
