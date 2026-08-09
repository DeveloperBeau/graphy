<script>
  import KbdHint from './KbdHint.svelte';

  export let state = [];

  function helpSections(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="keyboard-help">
  <KbdHint />
  <p>{helpSections(state)}</p>
</div>

<style>
  .keyboard-help {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
