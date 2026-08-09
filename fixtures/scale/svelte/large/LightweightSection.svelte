<script>
  import PresentPanel from './PresentPanel.svelte';
  import SpeckPanel from './SpeckPanel.svelte';
  import SimonPanel from './SimonPanel.svelte';
  import SimeckPanel from './SimeckPanel.svelte';
  import HightPanel from './HightPanel.svelte';
  import LeaPanel from './LeaPanel.svelte';
  import PrincePanel from './PrincePanel.svelte';
  import KleinPanel from './KleinPanel.svelte';

  export let rows = [];

  function orderLightweightPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lightweight-section">
  <PresentPanel />
  <SpeckPanel />
  <SimonPanel />
  <SimeckPanel />
  <HightPanel />
  <LeaPanel />
  <PrincePanel />
  <KleinPanel />
  <p>{orderLightweightPanels(rows)}</p>
</div>

<style>
  .lightweight-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
