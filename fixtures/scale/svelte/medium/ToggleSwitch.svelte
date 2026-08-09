<script>
  export let state = [];

  function toggleValue(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="toggle-switch">
  <p>{toggleValue(state)}</p>
</div>

<style>
  .toggle-switch {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
