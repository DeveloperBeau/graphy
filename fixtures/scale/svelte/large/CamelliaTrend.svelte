<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForCamellia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="camellia-trend">
  <TrendSparkline />
  <p>{trendForCamellia(rows)}</p>
</div>

<style>
  .camellia-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
