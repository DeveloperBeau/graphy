<script>
  import Rc5Trend from './Rc5Trend.svelte';
  import Rc5Detail from './Rc5Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeRc5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc5-panel">
  <Rc5Trend />
  <Rc5Detail />
  <CipherBadge />
  <p>{summarizeRc5(rows)}</p>
</div>

<style>
  .rc5-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
