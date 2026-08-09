<script>
  import Chacha20Trend from './Chacha20Trend.svelte';
  import Chacha20Detail from './Chacha20Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeChacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="chacha20-panel">
  <Chacha20Trend />
  <Chacha20Detail />
  <CipherBadge />
  <p>{summarizeChacha20(rows)}</p>
</div>

<style>
  .chacha20-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
