<script>
  import KhazadTrend from './KhazadTrend.svelte';
  import KhazadDetail from './KhazadDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeKhazad(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="khazad-panel">
  <KhazadTrend />
  <KhazadDetail />
  <CipherBadge />
  <p>{summarizeKhazad(rows)}</p>
</div>

<style>
  .khazad-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
