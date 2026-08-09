<script>
  export let state = [];

  function angleLabel(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="angle-badge">
  <p>{angleLabel(state)}</p>
</div>

<style>
  .angle-badge {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
