<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForXtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xtea-trend">
  <TrendSparkline />
  <p>{trendForXtea(rows)}</p>
</div>

<style>
  .xtea-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
