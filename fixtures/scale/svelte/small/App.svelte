<script>
  import AppHeader from './AppHeader.svelte';
  import Toolbar from './Toolbar.svelte';
  import PreviewPane from './PreviewPane.svelte';
  import StatusFooter from './StatusFooter.svelte';

  let lines = [];
  let preset = 'build';

  function applyPreset(event) {
    preset = event.detail.name;
  }
</script>

<main class="preview-app">
  <AppHeader />
  <Toolbar on:preset={applyPreset} />
  <PreviewPane {lines} {preset} />
  <StatusFooter count={lines.length} {preset} />
</main>

<style>
  .preview-app {
    display: grid;
    grid-template-rows: auto auto 1fr auto;
    height: 100vh;
  }
</style>
