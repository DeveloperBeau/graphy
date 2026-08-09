<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForTwofish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="twofish-trend">
  <TrendSparkline />
  <p>{trendForTwofish(rows)}</p>
</div>

<style>
  .twofish-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
