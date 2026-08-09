<script>
  import MarsPanel from './MarsPanel.svelte';
  import Rc6Panel from './Rc6Panel.svelte';
  import Cast256Panel from './Cast256Panel.svelte';
  import SaferPanel from './SaferPanel.svelte';
  import BlowfishPanel from './BlowfishPanel.svelte';
  import Cast5Panel from './Cast5Panel.svelte';
  import IdeaPanel from './IdeaPanel.svelte';
  import Rc5Panel from './Rc5Panel.svelte';

  export let rows = [];

  function orderClassicPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="classic-section">
  <MarsPanel />
  <Rc6Panel />
  <Cast256Panel />
  <SaferPanel />
  <BlowfishPanel />
  <Cast5Panel />
  <IdeaPanel />
  <Rc5Panel />
  <p>{orderClassicPanels(rows)}</p>
</div>

<style>
  .classic-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
