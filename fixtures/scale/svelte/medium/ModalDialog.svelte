<script>
  import ConfirmActions from './ConfirmActions.svelte';

  export let state = [];

  function openDialog(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="modal-dialog">
  <ConfirmActions />
  <p>{openDialog(state)}</p>
</div>

<style>
  .modal-dialog {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
