<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForXxtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xxtea-trend">
  <TrendSparkline />
  <p>{trendForXxtea(rows)}</p>
</div>

<style>
  .xxtea-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
