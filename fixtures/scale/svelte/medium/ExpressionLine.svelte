<script>
  import CursorCaret from './CursorCaret.svelte';

  export let state = [];

  function renderExpression(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="expression-line">
  <CursorCaret />
  <p>{renderExpression(state)}</p>
</div>

<style>
  .expression-line {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
