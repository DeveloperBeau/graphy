<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForLea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lea-trend">
  <TrendSparkline />
  <p>{trendForLea(rows)}</p>
</div>

<style>
  .lea-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
