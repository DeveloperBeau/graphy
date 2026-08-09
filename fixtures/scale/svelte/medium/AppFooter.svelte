<script>
  import ErrorBanner from './ErrorBanner.svelte';
  import ToastMessage from './ToastMessage.svelte';
  import ModalDialog from './ModalDialog.svelte';

  export let state = [];

  function footerNote(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="app-footer">
  <ErrorBanner />
  <ToastMessage />
  <ModalDialog />
  <p>{footerNote(state)}</p>
</div>

<style>
  .app-footer {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
