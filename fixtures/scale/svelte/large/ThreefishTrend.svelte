<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForThreefish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threefish-trend">
  <TrendSparkline />
  <p>{trendForThreefish(rows)}</p>
</div>

<style>
  .threefish-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
