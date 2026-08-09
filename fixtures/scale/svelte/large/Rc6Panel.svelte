<script>
  import Rc6Trend from './Rc6Trend.svelte';
  import Rc6Detail from './Rc6Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeRc6(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc6-panel">
  <Rc6Trend />
  <Rc6Detail />
  <CipherBadge />
  <p>{summarizeRc6(rows)}</p>
</div>

<style>
  .rc6-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
