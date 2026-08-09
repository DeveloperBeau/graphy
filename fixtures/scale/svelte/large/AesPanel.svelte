<script>
  import AesTrend from './AesTrend.svelte';
  import AesDetail from './AesDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeAes(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aes-panel">
  <AesTrend />
  <AesDetail />
  <CipherBadge />
  <p>{summarizeAes(rows)}</p>
</div>

<style>
  .aes-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
