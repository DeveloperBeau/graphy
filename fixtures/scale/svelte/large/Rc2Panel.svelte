<script>
  import Rc2Trend from './Rc2Trend.svelte';
  import Rc2Detail from './Rc2Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeRc2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc2-panel">
  <Rc2Trend />
  <Rc2Detail />
  <CipherBadge />
  <p>{summarizeRc2(rows)}</p>
</div>

<style>
  .rc2-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
