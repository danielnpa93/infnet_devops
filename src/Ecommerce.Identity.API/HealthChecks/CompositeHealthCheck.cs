using EasyNetQ.Logging;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Ecommerce.Identity.API.HealthChecks
{
    public class CompositeHealthCheck : IHealthCheck
    {
        private readonly HealthCheckService _healthCheckService;
        private readonly ILogger<CompositeHealthCheck> _logger;

        public CompositeHealthCheck(HealthCheckService healthCheckService,
                                    ILogger<CompositeHealthCheck> logger)
        {
            _healthCheckService = healthCheckService;
            _logger = logger;
        }
        public async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
        {
            var result = await _healthCheckService.CheckHealthAsync(cancellationToken);

            var unhealthChecks = result.Entries.Where(x => x.Value.Status != HealthStatus.Healthy);

            if (unhealthChecks.Any())
            {
                var errorMessages = unhealthChecks.Select(result => result.Value.Description);
                return HealthCheckResult.Unhealthy(string.Join(", ", errorMessages));
            }

            return HealthCheckResult.Healthy("Applicaton is healthy");
        }
    }
}
