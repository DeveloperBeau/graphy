<script>
  import RabbitTrend from './RabbitTrend.svelte';
  import RabbitDetail from './RabbitDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeRabbit(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rabbit-panel">
  <RabbitTrend />
  <RabbitDetail />
  <CipherBadge />
  <p>{summarizeRabbit(rows)}</p>
</div>

<style>
  .rabbit-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
