<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForLucifer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lucifer-trend">
  <TrendSparkline />
  <p>{trendForLucifer(rows)}</p>
</div>

<style>
  .lucifer-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
