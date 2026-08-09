<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSeed(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seed-trend">
  <TrendSparkline />
  <p>{trendForSeed(rows)}</p>
</div>

<style>
  .seed-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
