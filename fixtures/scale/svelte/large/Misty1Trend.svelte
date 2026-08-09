<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForMisty1(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="misty1-trend">
  <TrendSparkline />
  <p>{trendForMisty1(rows)}</p>
</div>

<style>
  .misty1-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
