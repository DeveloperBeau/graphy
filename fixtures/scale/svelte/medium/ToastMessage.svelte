<script>
  export let state = [];

  function dismissToast(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="toast-message">
  <p>{dismissToast(state)}</p>
</div>

<style>
  .toast-message {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
