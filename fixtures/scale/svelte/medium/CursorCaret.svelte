<script>
  export let state = [];

  function caretBlink(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cursor-caret">
  <p>{caretBlink(state)}</p>
</div>

<style>
  .cursor-caret {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
