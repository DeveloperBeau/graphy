<script>
  import AppHeader from './AppHeader.svelte';
  import DisplayPanel from './DisplayPanel.svelte';
  import Keypad from './Keypad.svelte';
  import SidePanels from './SidePanels.svelte';
  import AppFooter from './AppFooter.svelte';

  export let state = [];

  function wireApp(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="abacus-app">
  <AppHeader />
  <DisplayPanel />
  <Keypad />
  <SidePanels />
  <AppFooter />
  <p>{wireApp(state)}</p>
</div>

<style>
  .abacus-app {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
