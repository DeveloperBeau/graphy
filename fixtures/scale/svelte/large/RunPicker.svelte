<script>
  export let rows = [];

  function formatRunDate(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="run-picker">
  <p>{formatRunDate(rows)}</p>
</div>

<style>
  .run-picker {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
