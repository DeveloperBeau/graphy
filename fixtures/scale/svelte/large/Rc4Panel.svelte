<script>
  import Rc4Trend from './Rc4Trend.svelte';
  import Rc4Detail from './Rc4Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeRc4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc4-panel">
  <Rc4Trend />
  <Rc4Detail />
  <CipherBadge />
  <p>{summarizeRc4(rows)}</p>
</div>

<style>
  .rc4-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
