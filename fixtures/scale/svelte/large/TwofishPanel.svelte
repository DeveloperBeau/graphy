<script>
  import TwofishTrend from './TwofishTrend.svelte';
  import TwofishDetail from './TwofishDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeTwofish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="twofish-panel">
  <TwofishTrend />
  <TwofishDetail />
  <CipherBadge />
  <p>{summarizeTwofish(rows)}</p>
</div>

<style>
  .twofish-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
