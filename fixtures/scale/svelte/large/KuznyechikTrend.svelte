<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForKuznyechik(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kuznyechik-trend">
  <TrendSparkline />
  <p>{trendForKuznyechik(rows)}</p>
</div>

<style>
  .kuznyechik-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
