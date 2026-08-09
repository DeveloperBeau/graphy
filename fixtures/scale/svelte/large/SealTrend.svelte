<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seal-trend">
  <TrendSparkline />
  <p>{trendForSeal(rows)}</p>
</div>

<style>
  .seal-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
