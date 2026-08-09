<script>
  import TeaPanel from './TeaPanel.svelte';
  import XteaPanel from './XteaPanel.svelte';
  import XxteaPanel from './XxteaPanel.svelte';
  import ThreefishPanel from './ThreefishPanel.svelte';
  import Rc2Panel from './Rc2Panel.svelte';
  import SkipjackPanel from './SkipjackPanel.svelte';
  import GostPanel from './GostPanel.svelte';
  import SeedPanel from './SeedPanel.svelte';

  export let rows = [];

  function orderLegacyPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="legacy-section">
  <TeaPanel />
  <XteaPanel />
  <XxteaPanel />
  <ThreefishPanel />
  <Rc2Panel />
  <SkipjackPanel />
  <GostPanel />
  <SeedPanel />
  <p>{orderLegacyPanels(rows)}</p>
</div>

<style>
  .legacy-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
