<script>
  export let state = [];

  function pickAngleMode(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="angle-mode-picker">
  <p>{pickAngleMode(state)}</p>
</div>

<style>
  .angle-mode-picker {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
