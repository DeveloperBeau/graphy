<script>
  export let state = [];

  function insertConstant(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="constant-row">
  <p>{insertConstant(state)}</p>
</div>

<style>
  .constant-row {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
