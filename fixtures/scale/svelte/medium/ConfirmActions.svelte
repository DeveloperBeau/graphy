<script>
  export let state = [];

  function confirmChoice(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="confirm-actions">
  <p>{confirmChoice(state)}</p>
</div>

<style>
  .confirm-actions {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
